Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUL2VpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUL2VpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUL2VpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:45:22 -0500
Received: from main.gmane.org ([80.91.229.2]:59611 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261429AbUL2VpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:45:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: 2.6.10 resuming laptop from suspension f*cks usb subsystem
Date: Wed, 29 Dec 2004 23:43:52 +0200
Message-ID: <pan.2004.12.29.21.43.52.295304@yahoo.com>
References: <41D2C4FA.7010806@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home-33027.b.astral.ro
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 15:53:46 +0100, Miguelanxo Otero Salgueiro wrote:

> Apart from the timer drift thingie, 2.6.10 brought some new features like
> usb devices (ramdomly) not working after resuming from suspend mode.
> 

Same problem here.
For me, the work around was to remove the uhci-hcd before suspending and
inserting it after resuming.


