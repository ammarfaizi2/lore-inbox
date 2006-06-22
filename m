Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWFVVxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWFVVxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWFVVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:53:48 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57728 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S932659AbWFVVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:53:47 -0400
Date: Thu, 22 Jun 2006 14:53:44 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm code
Message-ID: <20060622215344.GH22737@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei> <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606211734480.12872@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch inserts security_task_movememory hook calls into memory
> management code to enable security modules to mediate this operation
> between tasks.
> 
> Since the last posting, the hook has been renamed following feedback from
> Christoph Lameter.
> 
> This patch is aimed at 2.6.18 inclusion.
> 
> Please apply.
> 
> Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Chris Wright <chrisw@sous-sol.org>
