Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVBBWwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVBBWwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVBBWuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:50:08 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:24989 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262913AbVBBWnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:43:35 -0500
Subject: RE: [Announce] megaraid_mbox 2.20.4.4 patch
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <sju@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570366265E@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570366265E@exa-atlanta>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 16:43:21 -0600
Message-Id: <1107384201.4541.30.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 10:56 -0500, Ju, Seokmann wrote:
> +	.sdev_attrs			= megaraid_device_attrs,
> +	.shost_attrs			= megaraid_class_device_attrs,

These are, perhaps, slightly confusing names.  The terms device and
class_device have well defined meanings in the generic device model,
neither of which is what you mean here.  Why not simply
megaraid_sdev_attrs and megaraid_shost_attrs?

Other than this, it looks fine to me too.

James


