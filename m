Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUC1HsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUC1HsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:48:06 -0500
Received: from ns.clanhk.org ([69.93.101.154]:40623 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262119AbUC1HsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:48:01 -0500
Message-ID: <4066833B.4080004@clanhk.org>
Date: Sun, 28 Mar 2004 01:48:11 -0600
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Status of the sata_sil driver for the VT8237
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org> <406680AB.8090204@stesmi.com>
In-Reply-To: <406680AB.8090204@stesmi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:

> Many A64 boards today come with a Promise SATA controller as well -
> works like a charm for me on an ASUS K8V Deluxe board here.

That's an option, as is just using the sii3112 that's been working so 
well, but that still puts the disks on the PCI bus.  The whole point is 
to get 300MB/sec of burstable I/O off the 133MB/s bus that's shared with 
the dual gigE controllers and a firewire camera.

-ryan
