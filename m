Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVHCSi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVHCSi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVHCSgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:36:07 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:30216 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262416AbVHCSf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:35:58 -0400
Date: Wed, 3 Aug 2005 14:35:31 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, tv@lio96.de, herbert@gondor.apana.org.au,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.32-pre1] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050803183531.GE20949@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, tv@lio96.de,
	herbert@gondor.apana.org.au, jgarzik@pobox.com,
	marcelo.tosatti@cyclades.com
References: <20050120202258.GA7687@tuxdriver.com> <20050120210739.GC7687@tuxdriver.com> <20050120212346.GD7687@tuxdriver.com> <20050803181814.GD20949@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803181814.GD20949@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 02:18:16PM -0400, John W. Linville wrote:

> +	 * we are stopped, we set both the LVI value and also we increment
> +	 * the LVI value to the next sg segment to be played so that when
> +	 * we call start, things will operate properly.  Since the CIV can't

Scratch that...bad comment...will repost...
-- 
John W. Linville
linville@tuxdriver.com
