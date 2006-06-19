Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWFSLqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWFSLqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWFSLqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:46:19 -0400
Received: from iona.labri.fr ([147.210.8.143]:57271 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932365AbWFSLqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:46:18 -0400
Date: Mon, 19 Jun 2006 13:46:17 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060619114617.GM4253@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
> I don't think this is the correct behavior. You can't allow some
> terminal input to affect init. It has been the de facto standard
> in Unix, that the only time one should have a controlling terminal
> is after somebody logs in and owns something to control. If you want
> a controlling terminal from your emergency shell, please exec /bin/login.

Ok, but people don't know that: they're given a shell, and wonder why on
hell ^C doesn't work...

Samuel
