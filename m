Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVLMSiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVLMSiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLMSiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:38:24 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:4646 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751185AbVLMSiX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:38:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JPMg3z8dgnDNG5QfsCYURPLhe49eS7UZaqIJ/aWt6yGOhLGDN+wMs3fVdWTB3RFPavIfLLEQqcAXiZQx1tOntiGffdZtTiwRLBynkZVxOdBm45/yMnjFSJqlKeWDEC2fYLfCiS2rT7zr88H92SI22a+A3rQdlEpG6p0DK7y7Dz8=
Message-ID: <58cb370e0512131038q49271226xfe932476bb05d2d0@mail.gmail.com>
Date: Tue, 13 Dec 2005 19:38:18 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2/2] ide/sis5513: Add support for 965 chipset
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1134498254295-git-send-email-bcollins@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1134498192250-git-send-email-bcollins@ubuntu.com>
	 <1134498254295-git-send-email-bcollins@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

SiS965 support has been merged recently (different patch because
sis5513_pci_tbl[] chunk of this patch causes problems on the real
SiS180 controller).

Please ask the user to test vanilla 2.6.15-rc5.

Thanks,
Bartlomiej

On 12/13/05, Ben Collins <bcollins@ubuntu.com> wrote:
> Tested by Ubuntu user.
>
> http://bugzilla.ubuntu.com/17236
>
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
