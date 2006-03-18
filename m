Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWCRP6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWCRP6r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWCRP6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:58:47 -0500
Received: from main.gmane.org ([80.91.229.2]:33499 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751339AbWCRP6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:58:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sat, 18 Mar 2006 15:58:28 +0000
Message-ID: <yw1xoe0368yj.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:shOaxC8/RG9KS5r4RnVeva/sFng=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Måns Rullgård wrote:
>> With the card in the bad slot I only got a few seconds of sound before
>> the machine locked up.  Since you have a different board, it could of
>> course still be a similar problem, just less likely to happen.
>> 
>> Which sound card were you using when your machine hung?
>
> I tried to use the onboard sound card at that time.

Hmm, mine crashed when I used the PCI card.  Using the onboard sound
was fine.

>>> Can you tell me how can I find the real device ID for my chipset? It
>>> *should* be the same one as the original writer of the patch wrote (he
>>> also had an ASUS A8V Deluxe as I understood), but the experience tells it
>>> is not.
>> 
>> lspci -n will list the PCI IDs in hex.
>
> Thanks.

Care to post the output?

-- 
Måns Rullgård
mru@inprovide.com

