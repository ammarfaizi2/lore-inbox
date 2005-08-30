Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVH3XQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVH3XQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVH3XQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:16:29 -0400
Received: from smtp.istop.com ([66.11.167.126]:26054 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932284AbVH3XQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:16:29 -0400
From: Daniel Phillips <phillips@istop.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC][PATCH 3 of 4] Configfs is really sysfs
Date: Tue, 30 Aug 2005 19:18:15 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200508310854.40482.phillips@istop.com> <200508310859.55746.phillips@istop.com> <20050830160643.65111ad0@dxpl.pdx.osdl.net>
In-Reply-To: <20050830160643.65111ad0@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301918.16002.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 August 2005 19:06, Stephen Hemminger wrote:
> On Wed, 31 Aug 2005 08:59:55 +1000
>
> Daniel Phillips <phillips@istop.com> wrote:
> > Configfs rewritten as a single file and updated to use kobjects instead
> > of its own clone of kobjects (config_items).
>
> Some style issues:
>  Mixed case in labels

I certainly agree.  This is strictly for comparison purposes and so I did not 
clean up the stylistic problems from the original... this time.

>  Bad identation

I did lindent it however :-)

> > +      Done:
>
> Why the mixed case label?

It shall die.

> > +void config_group_init_type_name(struct kset *group, const char *name,
> > struct kobj_type *type) +{
> > + kobject_set_name(&group->kobj, name);
> > + group->kobj.ktype = type;
> > + config_group_init(group);
> > +}
>
> Use tabs not one space for indent.

Urk.  Kmail did that to me, it has been broken that way for a year or so.  I 
will have to repost the whole set from a mailer that works.

Regards,

Daniel
