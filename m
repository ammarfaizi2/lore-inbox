Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbVIPDmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbVIPDmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 23:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbVIPDmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 23:42:55 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:1193 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S1030585AbVIPDmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 23:42:55 -0400
Message-ID: <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <1126823405.7034.14.camel@localhost.localdomain>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><43290893.7070207@pobox.com><1126790860.19133.75.camel@localhost.localdomain><61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>
    <1126823405.7034.14.camel@localhost.localdomain>
Date: Fri, 16 Sep 2005 00:42:53 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: izvekov@lps.ele.puc-rio.br, "Jeff Garzik" <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Iau, 2005-09-15 at 17:13 -0300, izvekov@lps.ele.puc-rio.br wrote:
>> Just tried that, and it doesnt help. Doesnt change behaviour, at least
>> for
>> my problem.
>
> What happens if you call the handler unconditionally ?
>

Hi again

>From what i understand up to now, my problem wasnt that the controller
triggered an interrupt with NIEN set, but that the handler was returning
it as not handled. See my reply to Jeff Garzig, the patch doesnt change
any logic in ata_interrupt.
