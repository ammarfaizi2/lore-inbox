Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLAR6f>; Fri, 1 Dec 2000 12:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbQLAR6Q>; Fri, 1 Dec 2000 12:58:16 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:14582 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S129809AbQLAR5p>; Fri, 1 Dec 2000 12:57:45 -0500
Date: Fri, 01 Dec 2000 16:01:12 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: Questions about Kernel 2.4.0.*
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Android <android@turbosport.com>, linux-kernel@vger.kernel.org
Message-id: <3A27CB48.38A1907C@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <001c01c05a86$45bb6380$19211518@vnnys1.ca.home.com>
 <20001130060732.A14250@wire.cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
<snip>
> Many people limit their e-mail messages to 80 columns.  What for?
> 
CF'mon, linebreaks are bloat! Those extra characters all around :-)

> The 'build' symlink is to make it easier for external module
> installation scripts to find the build directory for a given kernel.
> This build directory, in turn, will yield the correct header files,
> correct .config, correct compiler flags, etc., all of which can be
> important for building a working module.
> 

I hope 2.4.0 then does that better than 2.2.17:

$ ls /lib/modules/2.2.17*/build -l
/lib/modules/2.2.17/build -> /usr/src/linux
/lib/modules/2.2.17i10-0001/build -> /usr/src/linux
/lib/modules/2.2.17i8-0001/build -> /usr/src/linux
/lib/modules/2.2.17i8-0002/build -> /usr/src/linux
/lib/modules/2.2.17i8p2/build -> /usr/src/linux

though in all cases /usr/src/linux was only a symlink to the
corresponding tree in /usr/src/Linux/2/2/17/...
Should that not be first converted to paths that contain no symlinks?

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
