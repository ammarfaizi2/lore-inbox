Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWBWCSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWBWCSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWBWCSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:18:23 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:40523 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbWBWCSX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:18:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qjc2g9kCktnpy2wRasAaX0JoXWTaG6+YwZJv1bkuWVjw7D11+1jz7tGk4XRy+qvPEB0dDpUtxtQeaR/nfMAqRn5HP1T0i/xHgmiXLn83sn3D8xev5N4G3pul98dA6f/+cSeeTLNqQK8sxhHpgdgsT52lG/aOIeRFe0wpDIrJ/AI=
Message-ID: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com>
Date: Wed, 22 Feb 2006 23:18:19 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: cannot open initial console
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

When i tried kernel 2.6.15.4, i noticed i cant boot it, i get
"warning: cannot open initial console" then it reboots. I've searched
for it and found the breakage occurs from 2.6.15.1 to 2.6.15.2

Before i start to bisect to find the culpirit, and as there were few
changes, anyone has a good guess about what broke it?

Thanks all in advance.
