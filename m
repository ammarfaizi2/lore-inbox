Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVHOLAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVHOLAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 07:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVHOLAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 07:00:04 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:37043 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932662AbVHOLAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 07:00:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mhlZmoahxgq6tP41AWwwp90EBQKDdZjhqn0DEyrqIMpTDy/xzWNjw2fYKoAhdgF0JaJwtyndQpoW3SnpERPk97HsVS9bq1aQuJkHNZiV9sTBFzwJudyZe5jAmmZkwFkLFdP5Bto5dhz6qV1qXZsuKU6Hv+qpqLl7fZtvjZsQdBA=
Date: Mon, 15 Aug 2005 15:08:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Message-ID: <20050815110836.GA16201@mipter.zuzino.mipt.ru>
References: <20050815102925.GA843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815102925.GA843@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 12:29:25PM +0200, Stephane Wirtel wrote:
> With a laptop hard disk adaptop to usb, I do a modprobe with the
> usb-storage module. If I disconnect my hard disk, I get an oops.

> nvidia 3711688 14 - Live 0xe10f1000

> EIP:    0060:[<c019710b>]    Tainted: P      VLI

Is it reproducable without nvidia module loaded?

