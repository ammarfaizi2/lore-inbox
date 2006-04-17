Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWDQOWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWDQOWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWDQOWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:22:32 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:6930 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751014AbWDQOWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:22:31 -0400
Date: Mon, 17 Apr 2006 10:22:19 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] binary firmware and modules
Message-ID: <20060417142214.GI5042@tuxdriver.com>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org
References: <1145088656.23134.54.camel@localhost.localdomain> <200604151154.22787.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604151154.22787.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 11:54:22AM +0200, Oliver Neukum wrote:
> Am Samstag, 15. April 2006 10:10 schrieb Jon Masters:
> > The attached patch introduces MODULE_FIRMWARE as one way of advertising
 
> Strictly speaking, what is the connection with modules? Statically

The same as MODULE_AUTHOR, MODULE_LICENSE, etc.  The divide is more
logical than physical.

> compiled drivers need their firmware, too. Secondly, do all drivers
> know at compile time which firmware they'll need?

They have to know what they will request, do they not?

John
-- 
John W. Linville
linville@tuxdriver.com
