Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130620AbRBWWNx>; Fri, 23 Feb 2001 17:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130624AbRBWWNe>; Fri, 23 Feb 2001 17:13:34 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:65030 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S130620AbRBWWNb>;
	Fri, 23 Feb 2001 17:13:31 -0500
Message-ID: <20010223231327.A13627@win.tue.nl>
Date: Fri, 23 Feb 2001 23:13:27 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Andreas Dilger <adilger@turbolinux.com>, Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: filesystem statistics
In-Reply-To: <UTC200102221534.QAA243062.aeb@vlet.cwi.nl> <200102231854.f1NIsSR04313@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200102231854.f1NIsSR04313@webber.adilger.net>; from Andreas Dilger on Fri, Feb 23, 2001 at 11:54:28AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 11:54:28AM -0700, Andreas Dilger wrote:
> Andries Brouwer writes:
> > Here some statistics.
> 
> Can you generate statistics on the number of files in each directory,
> and the total size of each directory?
> 
> This would also be helpful to determine how often indexing will be used
> in an "average" system.

Hmm - there is no way this is an average system. It is just a random system.
For doing statistics on file names it is a valid example, I think.
For doing statistics on file sizes or directory sizes it is worthless.
Some people have few very large files, some have news spools or other
things with lots of small files in a directory.
(This particular system does not have a news spool.)

Anyway, I can give you the stats.

127533 directories
2555633 regular files
946 other files

Largest file: 678035456 bytes
Largest directory: 1283 links

Distribution of nlinks:

        0       1       2       3       4       5       6       7       8       9
0:      0       0       98330   13901   4510    2238    1624    1318    877    662
10:     668     490     519     307     308     226     157     140     101    62
20:     130     116     73      78      54      26      59      41      36     33
30:     13      24      15      23      12      11      14      40      25     21
40:     21      9       10      20      10      4       6       10      2      1
50:     3       3       1       2       1       4       11      3       1      1
60:     2       3       0       2       6       6       6       1       1      1
70:     7       2       0       2       0       4       3       0       1      3
80:     1       5       0       1       0       0       1       0       0      0
90:     1       0       1       1       0       1       2       3       1      0
100:    1       0       1       0       5       4       0       3       3      1
110:    0       1       0       0       0       0       4       0       1      0
120:    0       0       0       1       0       0       0       0       0      2
130:    0       0       1       0       1       0       0       0       1      0
140:    0       0       0       0       0       0       0       0       1      0
160:    0       0       0       1       0       0       0       0       0      1
170:    0       0       0       0       0       0       0       0       0      1
180:    0       0       1       0       0       0       0       1       0      0
200:    0       0       0       0       0       0       0       0       0      1
210:    1       0       0       0       0       0       0       0       0      0
220:    0       0       0       0       0       1       0       1       0      0
230:    0       0       0       0       0       0       0       0       0      1
250:    0       0       0       0       0       0       0       0       16     0
790:    1       0       0       0       0       0       0       0       0      0
1150:   0       0       0       1       0       0       0       0       0      0
1280:   0       0       0       1       0       0       0       0       0      0

(Interesting - I never thought about that, but it looks as if most directories are empty.)

Distribution of directory sizes (in 4kB blocks):

        0       1       2       3       4       5       6       7       8       9
0:      3       126133  763     247     35      38      21      18      26      5
10:     10      16      102     3       8       9       4       2       10      1
20:     4       1       5       4       20      9       15      6       0       3
30:     0       3       3       0       0       0       0       3       1       1
40:     0       0       0       0       0       0       0       0       0       0
50:     0       0       0       0       1       0       0       0       0       0
