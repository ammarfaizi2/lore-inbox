Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWAWX5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWAWX5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWAWX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:57:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8598 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964983AbWAWX5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:57:21 -0500
Date: Mon, 23 Jan 2006 18:56:42 -0500
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: use bytes as image size units
Message-ID: <20060123235642.GD6924@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200601240032.26735.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601240032.26735.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 12:32:26AM +0100, Rafael J. Wysocki wrote:
 > Hi,
 > 
 > This patch makes swsusp use bytes as the image size units, which is needed
 > for future compatibility.

With what ?  I don't see how clipping this range to a maximum of 4GB
will future-proof anything. What happens in a few years time when
I want to suspend my 8GB laptop ?

		Dave

