Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUBEMfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUBEMfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:35:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:58381 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265149AbUBEMf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:35:28 -0500
Date: Thu, 5 Feb 2004 12:35:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2 and INI9100U
Message-ID: <20040205123525.A31968@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Wojciech 'Sas' Cieciwa <cieciwa@alpha.zarz.agh.edu.pl>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58L.0402051400320.18104@alpha.zarz.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58L.0402051400320.18104@alpha.zarz.agh.edu.pl>; from cieciwa@alpha.zarz.agh.edu.pl on Thu, Feb 05, 2004 at 02:01:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 02:01:46PM +0100, Wojciech 'Sas' Cieciwa wrote:
> 
> Can anyone tell me why this driver is marked as broken ?
> I build this, and this works fine.

There's no error handling, so as soon as you hit some kind of bus
error you're screwed.

