Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUJTObM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUJTObM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbUJTO1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:27:06 -0400
Received: from mail5.iserv.net ([204.177.184.155]:27331 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S269979AbUJTOOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:14:14 -0400
Message-ID: <417672B3.4030801@didntduck.org>
Date: Wed, 20 Oct 2004 10:14:11 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Subject: Re: X does not start. vm86old returns ENOSYS??
References: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> How can vm86old from X return ENOSYS??
> I have no more ideas how to proceed from here.

Are you trying to run a 32-bit X server on a 64-bit kernel?  x86-64 does 
not support vm86 mode.

--
				Brian Gerst
