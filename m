Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318024AbSGWKUs>; Tue, 23 Jul 2002 06:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSGWKUs>; Tue, 23 Jul 2002 06:20:48 -0400
Received: from smtp-server4.tampabay.rr.com ([65.32.1.45]:56981 "EHLO
	smtp-server4.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S318024AbSGWKUr>; Tue, 23 Jul 2002 06:20:47 -0400
Message-ID: <3D3D2EBF.6AFB3B18@cfl.rr.com>
Date: Tue, 23 Jul 2002 06:23:59 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: bigphysarea
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 We have a pci reflective memory card that has no hardware scatter/gatter capabilities. Software scatter/gather is to slow for our needs. It has 16mb of mem that needs to be
contigously mapped into a user task. We have been using the bigphysarea patch and seems
to do what we need for this card. We have been using it sice the beginning to the 2.4 
series kernel. My question is, is this patch still nessessary or is there possibly a
way do do this now without the patch?

Ragards
Mark
