Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTKLJDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTKLJDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 04:03:23 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:13496 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261872AbTKLJDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 04:03:22 -0500
Date: Wed, 12 Nov 2003 08:59:52 +0000
From: Dave Jones <davej@redhat.com>
To: glee@gnupilgrims.org
Cc: Willy Tarreau <willy@w.ods.org>, Kaj-Michael Lang <milang@tal.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031112085952.GA31092@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, glee@gnupilgrims.org,
	Willy Tarreau <willy@w.ods.org>, Kaj-Michael Lang <milang@tal.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <20031112061909.GB9634@alpha.home.local> <20031112064942.GA7073@gandalf.chinesecodefoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112064942.GA7073@gandalf.chinesecodefoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 02:49:42PM +0800, glee@gnupilgrims.org wrote:
 > 
 > I think that we should wrap the msr.h include around a CONFIG_X86_MSR.

That config option is for the x86 MSR driver. You probably want to be
ifdefing CONFIG_X86

		Dave

