Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWFTGkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWFTGkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWFTGkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:40:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:27291 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965089AbWFTGkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:40:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pop/CXVgCv0n6XHl9LPl5xvMroqXA5EdS8ooeqbxXEIrypFWeUNevWROEIFok093uW41MQXZ/B0aQKWxxw4KvxGG+RBebNwUwH/qmI38eSXSf3iGKqyDMIWUtXMrJzgzdHths9RpQIS5KBqs1Q/onnFynngwazgn/EDCgiu7Hcg=
Message-ID: <3aa654a40606192340l67d0353fj875767d33d8bd493@mail.gmail.com>
Date: Mon, 19 Jun 2006 23:40:34 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20060620161006.C1079661@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
	 <20060620161006.C1079661@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> How reproducible is it?  Is it reproducible even after xfs_repair?
It happens everytime I try to delete the directory.

Also, forgot to mention I ran xfs_check on it and it gave me more
information than I had before:
More information, ran xfs_check and got the following:
missing free index for data block 0 in dir ino 1507133580
missing free index for data block 2 in dir ino 1507133580
missing free index for data block 3 in dir ino 1507133580
missing free index for data block 4 in dir ino 1507133580
missing free index for data block 5 in dir ino 1507133580
missing free index for data block 6 in dir ino 1507133580
missing free index for data block 7 in dir ino 1507133580
missing free index for data block 8 in dir ino 1507133580
missing free index for data block 9 in dir ino 1507133580

-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
