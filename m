Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVDRTGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVDRTGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVDRTGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:06:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63210 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262161AbVDRTGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:06:12 -0400
Date: Mon, 18 Apr 2005 15:05:52 -0400
From: Dave Jones <davej@redhat.com>
To: Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] procfs privacy: misc. entries
Message-ID: <20050418190552.GA26322@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= <lorenzo@gnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1113850012.17341.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1113850012.17341.71.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 08:46:52PM +0200, Lorenzo Hernández García-Hierro wrote:
 > This patch changes the permissions of the following procfs entries to
 > restrict non-root users from accessing them:
 > 
 >  - /proc/devices 
 >  - /proc/cmdline
 >  - /proc/version
 >  - /proc/uptime
 >  - /proc/cpuinfo

This is utterly absurd. You can find out anything thats in /proc/cpuinfo
by calling cpuid instructions yourself.
Please enlighten me as to what security gains we achieve
by not allowing users to see this ?

Restricting lots of the other files are equally absurd.

I'd also be very surprised if various random bits of userspace
broke subtley due to this nonsense.

		Dave

