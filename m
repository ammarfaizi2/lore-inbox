Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVDRB7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVDRB7A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDRB7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:59:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37861 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261593AbVDRB67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:58:59 -0400
Date: Sun, 17 Apr 2005 21:57:56 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: sfrench@samba.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove cifs_kcalloc
Message-ID: <20050418015756.GA10062@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, sfrench@samba.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
References: <20050418015202.GA3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418015202.GA3625@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 03:52:02AM +0200, Adrian Bunk wrote:
 > This patch removes cifs_kcalloc and replaces it with calls to
 > kcalloc(1, ...) .
 > 
 > Signed-off-by: Adrian Bunk <bunk@stusta.de>

As a followup patch you might want to check the return value
of all those calls before blindly deferencing them.

		Dave

