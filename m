Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSDIQtP>; Tue, 9 Apr 2002 12:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDIQtO>; Tue, 9 Apr 2002 12:49:14 -0400
Received: from mail.uni-freiburg.de ([132.230.2.46]:966 "EHLO uni-freiburg.de")
	by vger.kernel.org with ESMTP id <S310190AbSDIQtN> convert rfc822-to-8bit;
	Tue, 9 Apr 2002 12:49:13 -0400
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C++ and the kernel
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 09 Apr 2002 18:51:46 +0200
In-Reply-To: "Richard B. Johnson"'s message of "Tue, 9 Apr 2002 09:28:59 -0400 (EDT)"
Message-ID: <xb7u1qk6cil.fsf@camaro.informatik.uni-freiburg.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=cn-big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

    Richard> On Tue, 9 Apr 2002, Dr. David Alan Gilbert wrote:
    >> * Richard B. Johnson (root@chaos.analogic.com) wrote:
    >> I would like to rewrite the kernel in FORTRAN because this was 
    >> one of the first languages I learned.  Seriously, the
    >> kernel MUST be written in a procedural language.  It is the
    >> mechanism by which something is accomplished that defines an
    >> operating system kernel.  C++ is an object-oriented
    >> language, in fact the opposite of a procedural language. It
    >> is not suitable.  Bollox!  There are many places in the
    >> kernel that are actually very OO - look at filesystems for
    >> example. The super_operations sturcture is in effect a virtual
    >> function table.

    Richard> The file operations structure(s) are structures. They are
    Richard> not object- oriented in any way, and they are certainly
    Richard> not virtual.

The  term  "virtual"  has  a  very  specific  in  OO,  esp.   in  C++.
Unfortunately, this word isn't a  very faithful description of what it
means.  Java uses the keyword "abstract" for what is "virtual" in C++.
This is much more appropriate.

And "virtual function table", "vptr", "vtable" are also specific terms
in OO which  refer to implementation details of the  run-time of an OO
language.   To  you,  this  shouldn't  be anything  new.   A  "virtual
function table" is just an  array of pointers to functions.  It serves
essentially the same purpose  as the super_operations structure in the
Linux  kernel.  Instead  of having  to building  the table  (in source
code, not run-time) yourself, the  compiler of C++ and any OO language
would do  it for you  automatically, thereby saving typing  effort and
avoiding trivial typos.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

