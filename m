Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWCVOJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWCVOJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWCVOJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:09:46 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:39808 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751242AbWCVOJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:09:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=hDMFWCnYFWB37Vsr78OCKM4uza9xeq9IIBj9oPt0eIyFmE0v2N9H1BAYkXAT5+ZEJmhBEZVCcIowDLlQrUd4O/QrrljWOmWRCcnqST4nw2zLKXcfSIGYS0WUH3QtPEhycLAv1LAKc+wt/PdUobV6pyEi0dFBUWjRpQU+1dEbNrU=
Message-ID: <44215B8F.6060400@gmail.com>
Date: Wed, 22 Mar 2006 21:13:35 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: stefano.melchior@openlabs.it
CC: user-mode-linux-user@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX>
In-Reply-To: <20060322135015.GC8115@SteX>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefano Melchior wrote:
> On Wed, Mar 22, 2006 at 08:32:48PM +0700, Mikado wrote:
> Hi Mikado,

Hi Stex

> same problem as mine:
> ./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128MB eth0=tuntap,,,192.168.0.254
> 
> You wrongly used "mem" option!

I've checked my UML's memory, it's exactly 128MB. But thank you, I will
follow UML rules.

> First, see man user-mode-linux, you can not specify "mem=128MB", at least
> "mem=128M". But for issue tied to TT option sometimes you need to use
> "mem=xxxm" and sometimes "mem=xxxM".
> Please de-select TT in the uml kernel, then try again

Debugging UML requires running it under TT mode. Normally I run UML
under SKAS mode, everything is OK. I cannot get into GDB under SKAS mode
whenever I use 'debug' option.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIVuPNWc9T2Wr2JcRAjsWAKDZqL/h6J/aPez9thhcgF2+Ee7BNwCeMaxh
tLYonH5TOq0yg/7A6lCq3ag=
=etco
-----END PGP SIGNATURE-----
