Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbTLZJtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 04:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTLZJtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 04:49:08 -0500
Received: from crisium.vnl.com ([194.46.8.33]:63755 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S265154AbTLZJtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 04:49:05 -0500
Date: Fri, 26 Dec 2003 09:49:02 +0000
From: Dale Amon <amon@vnl.com>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       Dale Amon <amon@vnl.com>
Subject: Re: 2.6.0 compile failure
Message-ID: <20031226094902.GN4987@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, joshk@triplehelix.org,
	linux-kernel@vger.kernel.org
References: <20031226010204.GM4987@vnl.com> <20031226014527.GA12871@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226014527.GA12871@triplehelix.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 05:45:27PM -0800, Joshua Kwan wrote:
> On Fri, Dec 26, 2003 at 01:02:04AM +0000, Dale Amon wrote:
> > {standard input}:12164: Error: invalid character '_' in mnemonic
> > Internal error: Terminated (program cc1)
> > Please submit a full bug report.
> > See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> > For Debian GNU/Linux specific bugs,
> > please see /usr/share/doc/debian/bug-reporting.txt.
> 
> This is obviously a compiler bug. Myself, I've not been able to hit it.
> What GCC version are you using? I also use Debian:

True, but often one can do a code workaround until things get 
fixed. I might add that by making smbfs a module instead of
compiled in, I got a compile. 
 
> $ gcc -v
> [...]
> gcc version 3.3.3 20031206 (prerelease) (Debian)

gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.2/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.2 (Debian)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------
