Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWFGQd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWFGQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWFGQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:33:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55440 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932321AbWFGQd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:33:57 -0400
From: Andi Kleen <ak@suse.de>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG =?iso-8859-1?q?in=09arch/i386/kernel/nmi=2Ec=3A174?=
Date: Wed, 7 Jun 2006 18:33:38 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Shaohua Li <shaohua.li@intel.com>,
       Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <4485AC1F.9050001@goop.org> <20060607024938.GG11696@redhat.com>
In-Reply-To: <20060607024938.GG11696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071833.38773.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 04:49, Don Zickus wrote:
> Makes the start/stop paths of nmi watchdog more robust to handle the
> suspend/resume cases more gracefully.

Can someone with the problem please confirm the patch actually helps.

Thanks,

-Andi
