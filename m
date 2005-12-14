Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVLNNH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVLNNH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNNH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:07:28 -0500
Received: from relay4.usu.ru ([194.226.235.39]:25287 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932470AbVLNNH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:07:28 -0500
Message-ID: <43A018E4.2090907@ums.usu.ru>
Date: Wed, 14 Dec 2005 18:06:44 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Cc: LKML <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: [SERIAL, -mm] CRC failure
References: <403eda.8e05b5@familynet-international.net>
In-Reply-To: <403eda.8e05b5@familynet-international.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.11; VDF: 6.33.0.25; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Parrish wrote:
>         Three -mm kernels of late, and now v2.6.15-rc5-mm2, give
> frequent z-modem crc errors with minicom, lrz, and an external v90 modem
> to a couple of local bb's.  2.6.15-rc5-git2 and before are okay.

Does the error rate vary if you run a CPU hog (e.g. cat /dev/urandom 
 >/dev/null) or glxgears in parallel to minicom?

-- 
Alexander E. Patrakov
