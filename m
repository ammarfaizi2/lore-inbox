Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271294AbRHOQtI>; Wed, 15 Aug 2001 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271293AbRHOQs6>; Wed, 15 Aug 2001 12:48:58 -0400
Received: from p3EE3E82B.dip.t-dialin.net ([62.227.232.43]:4876 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S271285AbRHOQsn>;
	Wed, 15 Aug 2001 12:48:43 -0400
Date: Wed, 15 Aug 2001 18:50:05 +0200
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: Kurt Garloff <garloff@suse.de>,
        "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
        linux-lvm@sistina.com, lvm-devel@sistina.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sistina@sistina.com, mge@sistina.com
Cc: mge@sistina.com
Subject: Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815185005.A32239@sistina.com>
Reply-To: mauelshagen@sistina.com
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010815182548.U3941@gum01m.etpnet.phys.tue.nl>; from garloff@suse.de on Wed, Aug 15, 2001 at 06:25:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 06:25:48PM +0200, Kurt Garloff wrote:
> On Wed, Aug 15, 2001 at 05:56:59PM +0200, Heinz J . Mauelshagen wrote:
> > with all the kind support of the community to stabilize the Linux Logical
> > Volume Manager, we are proud to announce the production level release 1.0.
> [...]
> > This release contains minor changes to 0.9.1 Beta 8.
> > 
> > !!! YOU STILL NEED TO FOLLOW THE INSTRUCTIONS IN README.1ST !!!
> > See the CHANGELOG file contained in the tarball for further information.
> > 
> > We are still working together with Alan Cox on the integration of the
> > actual driver into vanilla. *Sorry* folks, we couldn't wait any longer ;-)
> 
> Is there finally a decent way to upgrade from 0.9.1b7?
> Or is it still required to have multiple versions of the utils installed
> just in order to be able to update from 0.9.1b7 to b8 (or 1.0)?

Well, as explained before on the lists we had an algorithm calculating
the offset to the first PE in place till 0.9.1 Beta 7.

Therefore, we *need* to run the installed version < LVM 0.9.1 Beta 8 to
retrieve that sector offset for all PVs and change the metadata to hold the
offset. No known way around this.

> 
> If yes, then I'd vote for not updating the kernel until this is fixed!

Well, we need to migrate the metadata in the future anyway once we want
to offer support for enhanced metadata reliability and redundancy.
We'll provide bidirectional migration tools for that then which will enable
the user to swicth back and forth between 2 installed LVM versions.

Let's keep the ball flat WRT to the migration path here.
We've got mails with positive LVM 0.9.1 Beta 8 upgrade reports and
no complaints TTBOMK.

> 
> Regards,
> -- 
> Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
> GPG key: See mail header, key servers         Linux kernel development
> SuSE GmbH, Nuernberg, DE                                SCSI, Security



-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
