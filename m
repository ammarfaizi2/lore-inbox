Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWJJPWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWJJPWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJJPWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:22:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41554 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750857AbWJJPWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:22:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Rj9PqFk/axhdNYI/NjNqGwehk5SOyx+wfUL1y+8v4BXZI4gJEHqaeb9VEsJ8xLV/T6jj1XSnUOo2jsxWTRKoJFEY0NB/tQChpquF3uMK9c+/zXbEQWCN4OFebK/FMT9V1hHv9M2WuYMetkH+ElV+bl1YE7heJXAz26Q0ZOz6FbA=
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the
	sony_acpi driver
From: Richard Hughes <hughsient@gmail.com>
To: Yu Luming <luming.yu@gmail.com>
Cc: Alessandro Guido <alessandro.guido@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
In-Reply-To: <200610102317.24310.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	 <20061001171912.b7aac1d8.akpm@osdl.org>
	 <20061002132549.9d164061.alessandro.guido@gmail.com>
	 <200610102317.24310.luming.yu@gmail.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 16:22:10 +0100
Message-Id: <1160493730.19004.1.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 23:17 +0800, Yu Luming wrote:
> It should be mapped to KEY_BRIGHTNESSDOWN/UP (linux/input.h)

Completely agree. Then userspace (like gnome-power-manager or
powersaved) can change the brightness based on policy and user-lockdown.

Richard.


