Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWEOKfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWEOKfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWEOKfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:35:19 -0400
Received: from natsluvver.rzone.de ([81.169.145.176]:20193 "EHLO
	natsluvver.rzone.de") by vger.kernel.org with ESMTP id S964871AbWEOKfR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:35:17 -0400
From: Oliver Neukum <oliver@neukum.name>
To: jayakumar.video@gmail.com
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver v2
Date: Mon, 15 May 2006 12:35:10 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200605150849.k4F8nXDb031881@localhost.localdomain>
In-Reply-To: <200605150849.k4F8nXDb031881@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605151235.10690.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Mai 2006 10:49 schrieb jayakumar.video@gmail.com:
> +       urb->status = 0;
> +       urb->actual_length = 0;

These are not needed. Indeed you should never write to those fields.

	Regards
		Oliver
