Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWJPIq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWJPIq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWJPIq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:46:58 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:18884 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1161219AbWJPIq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:46:57 -0400
Date: Mon, 16 Oct 2006 10:46:56 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Mohit Katiyar <katiyar.mohit@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS inconsistent behaviour
Message-ID: <20061016084656.GA13292@janus>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com> <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:13:00PM +0900, Mohit Katiyar wrote:
[...]
> 
> [Machine1:] while :; do mount -a -F -t nfs ;umount -a -t nfs ; done
> 

This will quickly run out of [privileged] TCP sockets unless mount and
nfs use UDP.

Try mounting with -o udp

-- 
Frank
