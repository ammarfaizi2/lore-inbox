Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbRENKxv>; Mon, 14 May 2001 06:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbRENKxl>; Mon, 14 May 2001 06:53:41 -0400
Received: from t2.redhat.com ([199.183.24.243]:32240 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262326AbRENKxZ>; Mon, 14 May 2001 06:53:25 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15103.19205.369749.71491@pizda.ninka.net> 
In-Reply-To: <15103.19205.369749.71491@pizda.ninka.net>  <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <m1y9s1jbml.fsf@frodo.biederman.org> <20010513181006.A10057@lucon.org> <m1sni8k9io.fsf@frodo.biederman.org> 
To: "David S. Miller" <davem@redhat.com>
Cc: ebiederm@xmission.com (Eric W. Biederman), "H . J . Lu" <hjl@lucon.org>,
        alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 May 2001 11:52:56 +0100
Message-ID: <27838.989837576@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  I hate config options that change how the core of the kernel boot
> makes decisions.  Things like "where is root", "what is my network
> address or where do I get that information" have no reasonable
> default.  This is why the command line args are there.

If you're told (by rdev because the poxy bootloader on the board can't 
pass args to the kernel) that root is /dev/nfs, and you don't have a 
command line telling you your IP information, then there _is_ a reasonable 
default, and it is to do DHCP.

--
dwmw2


