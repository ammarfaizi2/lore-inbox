Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWJ3RQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWJ3RQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbWJ3RQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:16:37 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:60559 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S1030541AbWJ3RQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:16:37 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Date: Mon, 30 Oct 2006 12:16:04 -0500
User-Agent: KMail/1.9.5
Cc: dev@openvz.org, linux-kernel@vger.kernel.org, devel@openvz.org
References: <20061030103356.GA16833@in.ibm.com> <20061030024320.962b4a88.pj@sgi.com> <20061030170916.GA9588@in.ibm.com>
In-Reply-To: <20061030170916.GA9588@in.ibm.com>
Organization: IBM LTC
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301116.04780.dmccr@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 11:09 am, Srivatsa Vaddagiri wrote:
> Hierarchy has implications in not just the kernel-user API, but also on
> the controller design. I would prefer to progressively enhance the
> controller, not supporting hierarchy in the begining.
> 
> However you do have a valid concern that, if we dont design the user-kernel
> API keeping hierarchy in mind, then we may break this interface when we
> latter add hierarchy support, which will be bad.
>
> One possibility is to design the user-kernel interface that supports
> hierarchy but not support creating hierarchical depths more than 1 in the
> initial versions. Would that work?

Is there any user demand for heirarchy right now?  I agree that we should 
design the API to allow heirarchy, but unless there is a current need for it 
I think we should not support actually creating heirarchies.  In addition to 
the reduction in code complexity, it will simplify the paradigm presented to 
the users.  I'm a firm believer in not giving users options they will never 
use.

Dave McCracken
