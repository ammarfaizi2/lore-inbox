Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTJEKdv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 06:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTJEKdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 06:33:51 -0400
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:26038 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263060AbTJEKdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 06:33:50 -0400
Message-ID: <3F7FF3B9.2000405@stesmi.com>
Date: Sun, 05 Oct 2003 12:34:33 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Enrico Bartky <info@realdos.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT600
References: <3F7F1AF1.4000608@realdos.de> <3F7F2EEB.30808@stesmi.com> <3F7F4369.9020507@realdos.de>
In-Reply-To: <3F7F4369.9020507@realdos.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico Bartky wrote:
> Nothing, I try to boot.... with my S-ATA HardDisk. As IDE Driver a take 
> the VIA82CXXXX...

It doesn't support the SATA portion of the 8237. Grab libata and use
that instead, then the harddrive will show up as a scsi drive.

// Stefan

