Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTI2VLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTI2VLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:11:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63108 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263002AbTI2VLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:11:19 -0400
Message-ID: <3F789FE8.6050504@pobox.com>
Date: Mon, 29 Sep 2003 17:11:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ULL fixes for qlogicfc
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org> <bla4fg$pbp$1@cesium.transmeta.com>
In-Reply-To: <bla4fg$pbp$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> 0xffffffff is unsigned int and will be promoted to

0xffffffff without a prefix is signed.

