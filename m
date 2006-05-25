Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWEYVoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWEYVoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWEYVoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:44:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48259 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030446AbWEYVoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:44:19 -0400
Date: Thu, 25 May 2006 17:44:13 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525214413.GE4328@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <e55715+usls@eGroups.com> <447622EA.90704@garzik.org> <20060525213952.GT13513@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525213952.GT13513@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 11:39:52PM +0200, Jan-Benedict Glaw wrote:
 > On Thu, 2006-05-25 17:34:34 -0400, Jeff Garzik <jeff@garzik.org> wrote:
 > > 
 > > find / -name libata-scsi.c
 > 
 > Which of the 10 versions showing up is the "right" one?

For the sake of compiling out-of-tree modules, it's also useless,
as sanitised headers (like Fedora's kernel-devel package) won't have this.

Following /lib/modules/`uname -r`/build is the only way this can work.
(And that should be true on any distro)

		Dave

-- 
http://www.codemonkey.org.uk
