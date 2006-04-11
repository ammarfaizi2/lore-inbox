Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDKLHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDKLHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDKLHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:07:30 -0400
Received: from moeglingen.blank.eu.org ([82.139.201.30]:6599 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750759AbWDKLH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:07:29 -0400
Date: Tue, 11 Apr 2006 13:07:22 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Cc: davej@redhat.com
Subject: i386 - msr support for xen
Message-ID: <20060411110722.GA12385@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org, davej@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

The speedstep modules uses MSR to do its work. XEN can't allow this and
the calls needs to be done via a hypercall into xen.

I only found a hacky patch in
http://article.gmane.org/gmane.comp.emulators.xen.devel/22282, which
converts one of the speedstep modules to use xen. Does someone know if
there is another solution raising?

Bastian

-- 
	"Beauty is transitory."
	"Beauty survives."
		-- Spock and Kirk, "That Which Survives", stardate unknown
