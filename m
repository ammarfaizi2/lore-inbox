Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263125AbSJBNbX>; Wed, 2 Oct 2002 09:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263121AbSJBNbX>; Wed, 2 Oct 2002 09:31:23 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:58360 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263120AbSJBNbW>; Wed, 2 Oct 2002 09:31:22 -0400
Subject: Re: PATCH: scsi device queue depth adjustability patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20021002014144.GA29093@redhat.com>
References: <20021002002854.GF28265@redhat.com>
	<1033521367.20103.57.camel@irongate.swansea.linux.org.uk> 
	<20021002014144.GA29093@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 14:44:25 +0100
Message-Id: <1033566265.23682.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 02:41, Doug Ledford wrote:
> I didn't provide a lot of details before because this machine doesn't have
> a serial console host to grab logs and I didn't write all the stuff down.  
> Then there is the additional fubar stuff but it's mainly in the category
> of "Red Hat Linux 8.0 made initrd images using nash as the shell blow
> chunks in regards to actually working with the 2.5.40 kernel, failing
> simple operations such as mounting /proc, which of course causes damn near
> everything else it tries to do to fail since the normal /proc files aren't
> available".

Ok first thing to try - does 2.4.20-pre8-ac3 also lock up. That will
seperate problems with the 2.5.40 kernel from IDE ones. In paticular I
notice you mention using initrd which doesnt seem to work in 2.5.40

