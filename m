Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269687AbUJGEfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269687AbUJGEfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269689AbUJGEfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:35:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58001 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269687AbUJGEe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:34:59 -0400
Message-ID: <4164C766.5000103@pobox.com>
Date: Thu, 07 Oct 2004 00:34:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, alan@redhat.com, david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
References: <20041004214803.GC2989@lists.us.dell.com>
In-Reply-To: <20041004214803.GC2989@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the problem ;-)

-#ifndef(CONFIG_EDD_SKIP_MBR)
+#ifndef CONFIG_EDD_SKIP_MBR

