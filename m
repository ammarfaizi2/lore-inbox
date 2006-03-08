Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWCHTaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWCHTaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCHTaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:30:12 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:55709 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932120AbWCHTaK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:30:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OwHZC0pBSU3zBbxwuNEZdcTmghR3ZysgfBIn3vhbm5BequFdjYFJiVXhdPHIvY5qELGk76jn0q+x/o4yOyVLE0R1KByQD2RAVCaPL49cz+INIKdSSFia9BLcPrdDC81BBP+p8bGNKlbGKNHG1kENswmY146rdfFUcVqv8KE2R3k=
Message-ID: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
Date: Wed, 8 Mar 2006 16:30:09 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: usbkbd not reporting unknown keys
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a multimedia keyboard with some keys not mapped in linux, which
i intend to create mappings for. When i connect it to serio0, those
unknown keys trigger messages on the console about it, but when its
conncted to a usb port, nothing gets printed, and Ive even set console
loglevel to 8. What am i missing?
