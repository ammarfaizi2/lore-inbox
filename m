Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUHLMh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUHLMh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUHLMh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:37:58 -0400
Received: from mivlgu.ru ([81.18.140.87]:20628 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S268531AbUHLMhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:37:41 -0400
Date: Thu, 12 Aug 2004 16:37:32 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Alan Jenkins <sourcejedi@phonecoop.coop>, linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace?
Message-Id: <20040812163732.7599de97.vsu@altlinux.ru>
In-Reply-To: <20040812001218.GA20341@animx.eu.org>
References: <41189AA2.3010908@phonecoop.coop>
	<20040810220528.GA17537@animx.eu.org>
	<4119DFB0.6050204@phonecoop.coop>
	<20040811164109.GA18761@animx.eu.org>
	<411A89BB.60505@phonecoop.coop>
	<20040811213322.GA19908@animx.eu.org>
	<411A92EC.6090609@phonecoop.coop>
	<20040812001218.GA20341@animx.eu.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__12_Aug_2004_16_37_32_+0400_6H_IanpbTOk+=BmQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__12_Aug_2004_16_37_32_+0400_6H_IanpbTOk+=BmQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 11 Aug 2004 20:12:18 -0400 Wakko Warner wrote:

> > I'm not sure this is necessary.  Can't you just do:
> > 
> > # dump -0 -B 700000 -u -z3 /home -f -| cdrecord /dev/hdb -
> > 
> > dump and cdrecord allow you to use "-" as a filename to indicate that 
> > output shoud be written to stdout and input should be read from stdin 
> > respectively.
> 
> Yes, but if I was to understand it right, dump will close/reopen at "700000"
> (whatever that is, 700000kb?).  That won't work with cdrecord since it's
> expecting a single input stream, not many seperated by a pause.  I'd
> consider it more like using tar with the multiple tape option.  When it is
> finished writing to a tape, it'll wait for the user to physically change
> tapes and start writing at the beginning of the new tape.

http://www.serice.net/shunt/ can arrange this.

--Signature=_Thu__12_Aug_2004_16_37_32_+0400_6H_IanpbTOk+=BmQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBG2SRW82GfkQfsqIRAmUwAJ9ArkdKtzVy7RiQ1IKo+XO1jAtBuACfYBT9
AzvN7NI1WxoWbAlY1aA0RRY=
=oNGu
-----END PGP SIGNATURE-----

--Signature=_Thu__12_Aug_2004_16_37_32_+0400_6H_IanpbTOk+=BmQ--
