Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263170AbVBCO3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbVBCO3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbVBCO3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:29:47 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:49955 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263557AbVBCOWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:22:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=raeSFuT+1PRvCj4FjkYimYijs6iTnqHCCxpuo+GZioQjCejrEph9lLWGzYL6CelfDvDxFYyaXEgHXH3XwdYzn/7mrnp8IZSYR5/uqEsirvvV5Qy6cLazPrms0xKsZ/08nT18MkK3+I90GsPQ4CZ/uDcPjbBrLCEO14ViTfj5Eog=
Message-ID: <58cb370e050203062052c5052@mail.gmail.com>
Date: Thu, 3 Feb 2005 15:20:54 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 12/29] ide: add ide_hwgroup_t.polling
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025538.GM621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025538.GM621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:55:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 12_ide_hwgroup_t_polling.patch
> >
> >       ide_hwgroup_t.polling field added.  0 in poll_timeout field
> >       used to indicate inactive polling but because 0 is a valid
> >       jiffy value, though slim, there's a chance that something
> >       weird can happen.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
