Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWAXTKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWAXTKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWAXTKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:10:12 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:51976 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S965001AbWAXTKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:10:10 -0500
Date: Tue, 24 Jan 2006 19:08:39 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060124190839.GA16445@deprecation.cyrius.com>
References: <20060124181945.GA21955@deprecation.cyrius.com> <20060124183432.GA27917@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124183432.GA27917@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones <davej@redhat.com> [2006-01-24 13:34]:
> Is there actually any practical reason why you would want to
> make the input layer modular ?

Not really, but if it doesn't work as a module then Kbuild shouldn't
allow you to configure it like that.
-- 
Martin Michlmayr
http://www.cyrius.com/
