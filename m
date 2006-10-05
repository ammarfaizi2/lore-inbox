Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWJEIP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWJEIP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWJEIP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:15:56 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:16784 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751221AbWJEIPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:15:55 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Thu, 5 Oct 2006 11:16:11 +0300
User-Agent: KMail/1.9.4
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, mchehab@infradead.org
References: <200609150901.33644.ismail@pardus.org.tr> <200610011034.57158.ismail@pardus.org.tr> <20061001091411.GA9647@uranus.ravnborg.org>
In-Reply-To: <20061001091411.GA9647@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610051116.12726.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01 Eki 2006 Paz 12:14 tarihinde, Sam Ravnborg şunları yazmıştı: 
> On Sun, Oct 01, 2006 at 10:34:56AM +0300, Ismail Donmez wrote:
> > On Sunday 01 October 2006 08:20, Kyle Moffett wrote:
[...]
> > > Just thinking about it we probably also need to educate sparse about
> > > __extension__ too.  Perhaps somebody could also add an sparse flag to
> > > make it warn about nonportable constructs in exported header files.
> > >
> > > I'd submit a patch but my knowledge of kernel makefiles and depmod is
> > > somewhere between zero and none, exclusive.
> >
> > Thanks, I will have a look at it.
>
> I assume you will same errors from the in-kernel modpost.
> If you do not do so then there is some inconsistency between depmod
> and modpost that ougth to be fixed.

The problem shows itself in the modpost, somehow __extension__ clause seems to 
foobar module CRC. I am not yet successfull on making modpost ignore 
__extension__ .

Any ideas appreciated.

Regards,
ismail
