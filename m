Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVF2PIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVF2PIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVF2PIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:08:16 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:45263 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261288AbVF2PIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:08:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=AFR58gIeNFaA0AqGRwWI/Ruzzz107O4FQDwAU2SSfviJgrb0XSoE4G0AAiGOVzskgfKLTInyHh6yUFtOEGdQLf90ufKEp62al6B9ve5FUEG9vohtfy5raAwSNC+etzGlwzUJfe15xU4VRY5h1IHEJkgDBarBcFgvoBeQdArDbnI=
Subject: psmouse sysfs problems
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 29 Jun 2005 17:08:05 +0200
Message-Id: <1120057685.31934.36.camel@blight.blightgroup>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pwd
/sys/bus/serio/devices/serio0
root@blight serio0 # cat protocol
ImPS/2
root@blight serio0 # cat resetafter
0
root@blight serio0 # echo 5 > res
resetafter  resolution
root@blight serio0 # echo 5 > resetafter
root@blight serio0 # cat resetafter
0
root@blight serio0 #            

and sending 0, 1, 2 to protocol changed nothing.
same for resolution.
i needed that feature to switch from synaptics to imps protocol and
back.

i'm using 2.6.12-git10.

what should i do?

