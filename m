Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHHTAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHHTAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUHHTAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:00:14 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:15157 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266147AbUHHTAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:00:12 -0400
Date: Sun, 8 Aug 2004 21:02:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only build modpost when modules enabled
Message-ID: <20040808190205.GA22610@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
References: <41079FC3.9010703@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41079FC3.9010703@quark.didntduck.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:44:51AM -0400, Brian Gerst wrote:
> Only build modpost when CONFIG_MODULES=y.

Added but made all targets in scripts/Makefile depend on actual configuration.
Thanks for input.

	Sam
