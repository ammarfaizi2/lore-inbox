Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280019AbRKDQGK>; Sun, 4 Nov 2001 11:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280017AbRKDQF7>; Sun, 4 Nov 2001 11:05:59 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:49295 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S280019AbRKDQFv>; Sun, 4 Nov 2001 11:05:51 -0500
Date: Sun, 4 Nov 2001 17:05:44 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Jakob ?stergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104170544.A10860@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20011104163354.C14001@unthought.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 04:33:54PM +0100, Jakob ?stergaard wrote:
> For each file "f" in /proc, there will be a ".f" file which is a
> machine-readable version of "f", with the difference that it may contain extra
> information that one may not want to present to the user in "f".
> 
> The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it is a
> list of elements, wherein an element can itself be a list (or a character string,
> or a host-native numeric type.  Thus, (key,value) pairs and lists thereof are
> possible, as well as tree structures etc.
> 
> All data types are stored in the architecture-native format, and a simple
> library should be sufficient to parse any dot-proc file.

Hmmmm. If someone would be able to implement new architecture which can
provide 1:1 sysctl/procfs support, there would be need for user space
programs parse proc filesystem. Then, /proc would be only good to administrators
to echo to/cat entries. So compatibility with old design can remain, and
new programs would be able to use the much more versatile sysctl support.
OK, it's a hard guess only. ;-)


- Gabor
