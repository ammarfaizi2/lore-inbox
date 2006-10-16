Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWJPT1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWJPT1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWJPT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:27:53 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:64178 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1422778AbWJPT1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:27:52 -0400
From: Oliver Neukum <oliver@neukum.org>
To: mfbaustx <mfbaustx@gmail.com>
Subject: Re: copy_from_user / copy_to_user with no swap space
Date: Mon, 16 Oct 2006 21:28:44 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <op.thi3x1mvnwjy9v@titan>
In-Reply-To: <op.thi3x1mvnwjy9v@titan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610162128.45229.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 16. Oktober 2006 21:19 schrieb mfbaustx:
> So, IF you MUST copy_from/to_user when in the context of the process, AND  
> IF you have no virtual memory/swapping, THEN must it not be true that you  
> can ALWAYS dereferences your user space pointers?

No. Your code may be only partially paged into RAM.
The same can happen for any mmaped data.

	Regards
		Oliver
