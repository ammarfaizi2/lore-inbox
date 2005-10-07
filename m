Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbVJGOFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVJGOFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVJGOFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:05:47 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:44259 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932647AbVJGOFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:05:46 -0400
Date: Fri, 7 Oct 2005 10:05:43 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
In-Reply-To: <21699.1128675816@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510071004520.31009@excalibur.intercode>
References: <Pine.LNX.4.63.0510061204040.26937@excalibur.intercode> 
 <Pine.LNX.4.63.0510061014540.26656@excalibur.intercode>
 <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode>
 <29942.1128529714@warthog.cambridge.redhat.com> <23641.1128596760@warthog.cambridge.redhat.com>
 <30054.1128611494@warthog.cambridge.redhat.com>  <21699.1128675816@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > > > > Should I expand the permissions mask to include a setattr?
> > > > 
> > > > Possibly for setperm and chown.
> > > 
> > > For setperm?
> > 
> > It changes an attribute of a key, for which you have DAC checks, therefore 
> > you could assume that we'd also want MAC checks.
> 
> Does it matter that you can take away your own permission to change the
> permissions?

Not that I'm aware of.


- James
-- 
James Morris
<jmorris@namei.org>
