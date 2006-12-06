Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936948AbWLFRow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936948AbWLFRow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936945AbWLFRow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:44:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:43795 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936950AbWLFRos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:44:48 -0500
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Date: Wed, 6 Dec 2006 18:31:14 +0100
User-Agent: KMail/1.9.5
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Peter Stuge <stuge-linuxbios@cdy.org>,
       Stefan Reinauer <stepan@coresystems.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, "Lu, Yinghai" <yinghai.lu@amd.com>,
       linuxbios@linuxbios.org
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com> <200612042001.09808.david-b@pacbell.net> <m1hcwa7gjw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1hcwa7gjw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061831.14268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2006 12:01, Eric W. Biederman wrote:
> 
> Ok due to popular demands here is the slightly fixed patch that works
> on both i386 and x86_64.  For the i386 version you must not have
> HIGHMEM64G enabled. 
> 
> I just rolled it all into one patch as I'm to lazy to transmit all
> 3 of them.


You should definitely move the usb code to a separate file

Documentation/* needs to document the new option

Also for usb console keep should be made default because the output won't
be duplicated.


-Andi
