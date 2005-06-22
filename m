Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVFVBY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVFVBY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVFVBY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:24:58 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:18385 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262471AbVFVBXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:23:46 -0400
Message-Id: <200506220123.j5M1NYRh020851@ms-smtp-05-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue, 21 Jun 2005 20:22:21 -0500
To: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] v9fs: Fix FSF postal address in source headers
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update FSF address in v9fs source code
as suggested by Jan-Benedict Glaw.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit d69bf28ad7f2098cef822023c93f49ce556a72d9
tree 95503fd0bc20c0d345fe9929728c965462296850
parent a69dbd409d6141c0ea77644e0d4ea542ec5eb15c
author Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:07:40 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:07:40 -0500

 fs/9p/9p.c         |    6 ++++--
 fs/9p/9p.h         |    6 ++++--
 fs/9p/conv.c       |    6 ++++--
 fs/9p/conv.h       |    6 ++++--
 fs/9p/debug.h      |    6 ++++--
 fs/9p/error.c      |    6 ++++--
 fs/9p/error.h      |    6 ++++--
 fs/9p/fid.c        |    6 ++++--
 fs/9p/fid.h        |    6 ++++--
 fs/9p/idpool.c     |    6 ++++--
 fs/9p/idpool.h     |    6 ++++--
 fs/9p/mux.c        |    6 ++++--
 fs/9p/mux.h        |    6 ++++--
 fs/9p/trans_sock.c |    6 ++++--
 fs/9p/transport.h  |    6 ++++--
 fs/9p/v9fs.c       |    6 ++++--
 fs/9p/v9fs.h       |    6 ++++--
 fs/9p/v9fs_vfs.h   |    6 ++++--
 fs/9p/vfs_dentry.c |    6 ++++--
 fs/9p/vfs_dir.c    |    7 ++++---
 fs/9p/vfs_file.c   |    7 ++++---
 fs/9p/vfs_inode.c  |    8 +++++---
 fs/9p/vfs_super.c  |    6 ++++--
 23 files changed, 93 insertions(+), 49 deletions(-)

diff --git a/fs/9p/9p.c b/fs/9p/9p.c
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
--- a/fs/9p/9p.h
+++ b/fs/9p/9p.h
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/conv.h b/fs/9p/conv.h
--- a/fs/9p/conv.h
+++ b/fs/9p/conv.h
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/debug.h b/fs/9p/debug.h
--- a/fs/9p/debug.h
+++ b/fs/9p/debug.h
@@ -15,8 +15,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/error.c b/fs/9p/error.c
--- a/fs/9p/error.c
+++ b/fs/9p/error.c
@@ -21,8 +21,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/error.h b/fs/9p/error.h
--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -22,8 +22,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -14,8 +14,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -14,8 +14,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/idpool.c b/fs/9p/idpool.c
--- a/fs/9p/idpool.c
+++ b/fs/9p/idpool.c
@@ -15,8 +15,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/idpool.h b/fs/9p/idpool.h
--- a/fs/9p/idpool.h
+++ b/fs/9p/idpool.h
@@ -15,8 +15,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
--- a/fs/9p/mux.h
+++ b/fs/9p/mux.h
@@ -16,8 +16,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
--- a/fs/9p/trans_sock.c
+++ b/fs/9p/trans_sock.c
@@ -18,8 +18,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/transport.h b/fs/9p/transport.h
--- a/fs/9p/transport.h
+++ b/fs/9p/transport.h
@@ -16,8 +16,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -15,8 +15,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -15,8 +15,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -17,8 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -17,9 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -17,9 +17,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -17,9 +17,11 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
+ *      
  */
 
 #include <linux/module.h>
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -18,8 +18,10 @@
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor 
+ *  Boston, MA  02111-1301  USA
  *
  */
 
