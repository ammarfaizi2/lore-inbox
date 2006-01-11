Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWAKNs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWAKNs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWAKNs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:48:58 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:63938 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751598AbWAKNs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:48:58 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       lgb@lgb.hu
In-Reply-To: <1136985918.6547.115.camel@tara.firmix.at>
References: <20060111123745.GB30219@lgb.hu>
	 <1136983910.2929.39.camel@laptopd505.fenrus.org>
	 <20060111130255.GC30219@lgb.hu>  <1136985918.6547.115.camel@tara.firmix.at>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 13:49:21 +0000
Message-Id: <1136987361.6517.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 213.104.11.16
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: OT: fork(): parent or child should run first?
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 14:25 +0100, Bernd Petrovitsch wrote:
> Then this leaves the race if an old pid is reused in a newly created
> process before the last instances of that pid is cleaned up.

The PID won't be available to be re-used until the signal handler has
called waitpid() on it?

Ian.

-- 
Ian Campbell
Current Noise: Sloth - Wishman

I understand why you're confused.  You're thinking too much.
		-- Carole Wallach.

