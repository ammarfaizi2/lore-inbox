Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVKRI4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVKRI4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVKRI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:56:46 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:49387 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932617AbVKRI4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:56:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=povoosXde+OesvvSq2JZsL0463EvLd1wQ8GeTaOP4kEo6spcEd5LIHMrwlX0lnxuohoCXmoz9jdqaxKlbDEr6aHAOrMHkUSTbdb8aaqairl2Ao3IyLFhBdC1mY1z2GbhZJiXV+guElRQxh+zdn/kfZn3kqRCR4IiHar0vYzc2Tc=
Message-ID: <40f323d00511180056i5bafa5c3qffbd3b774b499ac4@mail.gmail.com>
Date: Fri, 18 Nov 2005 09:56:43 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051117234645.4128c664.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1369_8877175.1132304203974"
References: <20051117234645.4128c664.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1369_8877175.1132304203974
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/18/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/=
2.6.15-rc1-mm2/
>
>
> - I'm releasing this so that Hugh's MM rework can get a spin.
>
>   Anyone who had post-2.6.14 problems related to the VM_RESERVED changes
>   (device drivers malfunctioning, obscure userspace hardware-poking
>   applications stopped working, etc) please test.
>
>   We'd especially like testing of the graphics DRM drivers across as many
>   card types as poss.
>
I tried running neverball and had "bad page state".

dmesg and lspci -v attached

Please ask if you need more informations.

regards,

Benoit

------=_Part_1369_8877175.1132304203974
Content-Type: application/octet-stream; name=dmesg.log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.log"


------=_Part_1369_8877175.1132304203974
Content-Type: application/octet-stream; name=lspci
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci"


------=_Part_1369_8877175.1132304203974--
