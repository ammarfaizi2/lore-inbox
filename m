Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266918AbVBERi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266918AbVBERi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266943AbVBERi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 12:38:27 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:36126 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266918AbVBERiM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 12:38:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fF0sOA36lBVmCFQRg/KeHFiJZ3IFv5S2FGJ5DabEkSJ1dqQV6Wd2Bo3HIdUpSQ9IWF4jFK3aiyhqtQBHaVRxYx0LwFEy/+kDMQ8vhbKmLr5MXW3O+VJJq3tSMOmDEDlcvf1cx1iojOMxbZzS3rbPAQFyk+itu9lfzSQX9UrjEcY=
Message-ID: <9e47339105020509382adbbf39@mail.gmail.com>
Date: Sat, 5 Feb 2005 12:38:07 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger@gmx.at>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Cc: acpi-devel@lists.sourceforge.net, Ondrej Zary <linux@rainbow-software.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502051748.43547.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <4204B3C1.80706@rainbow-software.org>
	 <9e473391050205074769e4f10@mail.gmail.com>
	 <200502051748.43547.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 17:48:43 +0100, Stefan Dösinger
<stefandoesinger@gmx.at> wrote:
> The reset code of radeon card seems to be easy to reverse engineer. I have
> started an attempt and I have 50-60% of my radeon M9 reset code implemented
> in a 32 bit C program. I had to stop due to school reasons.

The problem with the radeon reset code is that there are many, many
variations of the radeon chips, including different steppings of the
same part. The ROM is matched to the paticular bugs of the chip. From
what I know ATI doesn't even have a universal radeon reset program.

-- 
Jon Smirl
jonsmirl@gmail.com
