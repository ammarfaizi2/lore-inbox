Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTFYOVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFYOVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:21:40 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:41989 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264491AbTFYOVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:21:40 -0400
Date: Wed, 25 Jun 2003 15:35:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: grendel@debian.org, Steve Lord <lord@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625153545.A16074@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, grendel@debian.org,
	Steve Lord <lord@sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com> <20030625134129.GG1745@thanes.org> <1056551143.5779.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056551143.5779.0.camel@laptop.fenrus.com>; from arjanv@redhat.com on Wed, Jun 25, 2003 at 04:25:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 04:25:44PM +0200, Arjan van de Ven wrote:
> another question is why is this a filesystem specific option and not a
> generic option ?

Heh, I wonder the same when this was implemented the first time.

It should probably move to VFS.

