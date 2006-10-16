Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWJPJjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWJPJjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWJPJjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:39:08 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:20164 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1030322AbWJPJjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:39:06 -0400
Date: Mon, 16 Oct 2006 11:39:04 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Mohit Katiyar <katiyar.mohit@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS inconsistent behaviour
Message-ID: <20061016093904.GA13866@janus>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com> <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com> <20061016084656.GA13292@janus> <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 06:35:24PM +0900, Mohit Katiyar wrote:
> Hi,
> But I think unmounting will free the sockets.

Try "netstat -t", when the problem occurs. It will probably
show a lot tcp connections in state TIME_WAIT.

-- 
Frank
