Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUEEWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUEEWMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264817AbUEEWMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:12:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264820AbUEEWMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:12:35 -0400
Date: Wed, 5 May 2004 15:48:38 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
Message-ID: <20040505184838.GC1350@logos.cnet>
References: <4090BBF1.6080801@watson.ibm.com> <20040504173529.GE11346@logos.cnet> <409832D2.2020507@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409832D2.2020507@watson.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 08:18:26PM -0400, Shailabh Nagar wrote:

> >It sounds to me the classification engine can be moved to userspace? 
> >
> >Such "classification" sounds a better suited to be done there.
> 
> I suppose it could. However, one of our design objectives was to 
> support multi-threaded server apps where each thread (task) changes 
> its class fairly rapidly (say every time it starts doing work on 
> behalf of a more/less important transaction). Doing a transition to 
> userspace and back may be too costly for such a scenario.

But who sets the priority of the tasks is userspace anyway, isnt? AFAICS its
userspace who knows which transaction is more/less important. 

> There might also be some concerns with keeping the reclassify 
> operation atomic wrt deletion of the target class...but we haven't 
> thought this through for userspace classification.

How often is a reclassify operation done?

> >Note: I haven't read the code yet.
> >
> 
> Why just read when you can test as well :-) We just released a testing 
> tarball at http://ckrm.sf.net.. any inputs, bugs will be most welcome !
> 
> Looking forward to more inputs,

Yeah, I'm just nitpicking from the outside and haven't contributed 
to anything, so...

